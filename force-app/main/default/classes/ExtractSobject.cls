public class ExtractSobject
{
    public String fieldSetObj{get;set;}
    public String Selectedobject { get; set; }  
    public List<string> lstOfFieldSet{get;set;}
    public List<SelectOption> options{get;set;}
    public String queryString{get;set;}
    public List<sObject> objectRecordList{get;set;}
    public list<string> lstOfFields{get;set;}
    public integer counter=0;
    public integer list_size=20;
    public integer total_size;
    
    public List<SelectOption> getSelectedobjnames()
    {
        
        List<Schema.SObjectType> obj = Schema.getGlobalDescribe().Values();//All Sobject We get
        //System.debug('obj'+obj);
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('--Select Object--','--Select Object--')); //idk
        for(Schema.SObjectType st : obj)   
        {
            //System.debug('Schema.SObjectType'+st);
            if(Selectedobject == null || Selectedobject=='' )
            {    
                //System.debug('Selectedobject'+Selectedobject);   
                Selectedobject = st.getDescribe().getName();
                
                
            }
            if(options.size() < 999){
                options.add(new SelectOption(st.getDescribe().getName(),st.getDescribe().getName()));
                
            }
            
        }
        //System.debug('Options'+options);
        return options;
        
    }
    
    
    public List<SelectOption> getSelectedobjFields(){
        List<string> lstOfFieldSet = new List<String>();
        List<SelectOption> options = new List<SelectOption>();
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe();//Schema. getGlobalDescribe() is used to get a map with describe information about every single object in the organization.
        //System.debug('GlobalDescribeMap'+GlobalDescribeMap);
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(Selectedobject);
        //System.debug('SObjectTypeObj'+SObjectTypeObj);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();// Returns the describe sObject result for this field 
        //System.debug('DescribeSObjectResultObj'+DescribeSObjectResultObj);
        
        //system.debug('====>' + DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName));
        
        Map<String,Schema.FieldSet> fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap();
        //System.debug('fieldSetObj'+fieldSetObj);
        options.add(new SelectOption('none','none'));
        for(string st : fieldSetObj.keyset()){
            //System.debug('fieldSetObj.keyset'+st);
            options.add(new SelectOption(st,st));
        }
        //System.debug('Options'+options);
        return options;
    }
    public void fetchObjectRecordValues(){
        list<sObject> lstOfRecords = new List<sObject>();
        lstOfFields = new List<string>();
        //system.debug('fieldSetObj@@-->'+fieldSetObj+'----Selectedobject'+Selectedobject);
        List<Schema.FieldSetMember> fieldSetMemberList =  readFieldSet(fieldSetObj,Selectedobject);
        for(Schema.FieldSetMember fieldSetMemberObj : fieldSetMemberList)
        {
            lstOfFields.add(fieldSetMemberObj.getFieldPath());
            system.debug('API Name ====>' + fieldSetMemberObj.getFieldPath()); //api name
            system.debug('Label ====>' + fieldSetMemberObj.getLabel());
            system.debug('Required ====>' + fieldSetMemberObj.getRequired());
            system.debug('DbRequired ====>' + fieldSetMemberObj.getDbRequired());
            system.debug('Type ====>' + fieldSetMemberObj.getType());   //type - STRING,PICKLIST
        } 
        String queryString = 'select id';
        for(string fld : lstOfFields) {
            queryString += ', ' + fld;
        }
        queryString += ' from '+Selectedobject;
        objectRecordList = Database.query(queryString);
        total_size = objectRecordList.size();
        queryString += ' limit :list_size offset :counter' ;
        objectRecordList = new List<sObject>();
        objectRecordList = Database.query(queryString);
        
    }
    
    public List<Schema.FieldSetMember> readFieldSet(String fieldSetObj, String Selectedobject){
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(Selectedobject);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        
        //system.debug('====>' + DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName));
        
        Schema.FieldSet fieldSetObjj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetObj);
        
        //List<Schema.FieldSetMember> fieldSetMemberList =  fieldSetObj.getFields();
        //system.debug('fieldSetMemberList ====>' + fieldSetMemberList);  
        return fieldSetObjj.getFields(); 
    } 
    public PageReference Beginning() { //user clicked beginning
        counter = 0;
        fetchObjectRecordValues();
        return null;
    }
    
    public PageReference Previous() { //user clicked previous button
        counter -= list_size;
        fetchObjectRecordValues();
        return null;
    }
    
    public PageReference Next() { //user clicked next button
        counter += list_size;
        fetchObjectRecordValues();
        return null;
    }
    
    public PageReference End() { //user clicked end
        counter = total_size - math.mod(total_size, list_size);
        fetchObjectRecordValues();
        return null;
    }
    
    public Boolean getDisablePrevious() { 
        //this will disable the previous and beginning buttons
        if (counter>0) return false; else return true;
    }
    
    public Boolean getDisableNext() { //this will disable the next and end buttons
        if (counter + list_size < total_size) return false; else return true;
    }
    
    public Integer getTotal_size() {
        return total_size;
    }
    
    public Integer getPageNumber() {
        return counter/list_size + 1;
    }
    
    public Integer getTotalPages() {
        if (math.mod(total_size, list_size) > 0) {
            return total_size/list_size + 1;
        } else {
            return (total_size/list_size);
        }
    }
    
    
}