describe 'SP_IG_Import_MasterData' do

    
    context "Record details available on file but not in CCW: Record will be created in CCW" do
     it "When calling SP_IG_Import_MasterData it should insert/update the records and it should match with ResultSet_masterdata_insert.csv" do
 
        result = sproc("SP_IG_Import_MasterData", :mspID => 13, :clientID => 87, :XmlData => '<root><row><Column1>Test002</Column1><Column2>Test-Desc2</Column2></row></root>', :jobMasterSettingId => 17)
      
        res=query("select CostCenterNumber,CostCenterName from ST_PM_CostCenterMaster where clientid=87 and CostCenterNumber='Test002'")
        expect(res).to match("ResultSet_masterdata_insert.csv")
        puts 'Sucess'
    end

 end
 context "Record details available on file and in CCW (difference in description): Record description will be updated based on Record ID" do
    it "When calling SP_IG_Import_MasterData it should insert/update the records and it should match with ResultSet_masterdata_update.csv" do
       result = sproc("SP_IG_Import_MasterData", :mspID => 13, :clientID => 87, :XmlData => '<root><row><Column1>Test001</Column1><Column2>Test-Desc</Column2></row></root>', :jobMasterSettingId => 17)
       res=query("select CostCenterNumber,CostCenterName from ST_PM_CostCenterMaster where clientid=87 and CostCenterNumber='Test001'")
       expect(res).to match("ResultSet_masterdata_update.csv")
       puts 'Sucess'
   end

end

context "Duplicate Records" do
    it "When calling SP_IG_Import_MasterData it should insertonly one record and it should match with ResultSet_masterdata_duplicate.csv" do
       result = sproc("SP_IG_Import_MasterData", :mspID => 13, :clientID => 87, :XmlData => '<root><row><Column1>Test003</Column1><Column2>Test-Desc3</Column2></row><row><Column1>Test003</Column1><Column2>Test-Desc3</Column2></row></root>', :jobMasterSettingId => 17)
       res=query("select CostCenterNumber,CostCenterName from ST_PM_CostCenterMaster where clientid=87 and CostCenterNumber='Test003'")
       expect(res).to match("ResultSet_masterdata_duplicate.csv")
       puts 'Sucess'
   end

end

end