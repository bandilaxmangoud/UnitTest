require 'nokogiri' 

describe 'validating CostCenter master file scenarios' do     
        
    before do
        doc = File.open("data//inputData//IBX_CostCenter_Data.xml") { |f| Nokogiri::XML(f) }
        result = sproc("SP_IG_Import_MasterData",
                :mspID => 13,
                :clientID => 87, 
                :XmlData => doc.to_s, 
                :jobMasterSettingId => 17)
    end

    
    it "creates a new record" do
 
        res = query( "select CostCenterNumber,CostCenterName 
                      from ST_PM_CostCenterMaster 
                      where CostCenterNumber = 'Test00100'
                      and clientid = 87" )
        
        expect(res[0][:"CostCenterNumber"].to_s).to be == "Test00100"
        puts "created new record with 
        CostCenterNumber is: #{res[0][:"CostCenterNumber"].to_s}
        and CostCenterName is: #{res[0][:"CostCenterName"].to_s}" 

    end
    

    it "does not creates a record with blank CostCenterNumber" do
 
        res = query( "select CostCenterNumber,CostCenterName 
                      from ST_PM_CostCenterMaster 
                      where CostCenterNumber =  'Test002' 
                      and clientid = 87" )

        expect(res).to be_empty
        puts 'skipping record with blank CostCenterNumber'
       
    end


    it "creates a record with blank CostCenterName" do
 
        res = query( "select CostCenterNumber, CostCenterName 
                      from ST_PM_CostCenterMaster
                      where CostCenterNumber = 'Test00400'
                      and clientid = 87" )

        expect(res[0][:"CostCenterName"].to_s).to be_empty
        puts "created record with blank description
        CostCenterNumber: #{res[0][:"CostCenterNumber"].to_s}
        and CostCenterName: #{res[0][:"CostCenterName"].to_s}" 

    end


    it "does not creates duplicate records" do
 
        res = query( "select CostCenterNumber 
                      from ST_PM_CostCenterMaster 
                      where CostCenterNumber = 'Test00300' 
                      and clientid = 87" )

        expect(res.count).to eql (1)
        puts "skipping records with duplicate CostCenterNumber"    
        
    end

    
    it "updates existing record " do
        
        res = query( "select CostCenterName 
                      from ST_PM_CostCenterMaster 
                      where CostCenterNumber = '67322' 
                      and clientid = 87" )

        expect(res[0][:"CostCenterName"].to_s).to be == "(AHA)"
        puts "updated CostCenterName as: #{res[0][:"CostCenterName"].to_s}"
        
    end
   

end

#IBX_USER_IMPORT.rb --format html --out rspec_results<%= ENV['TEST_ENV_NUMBER']%>.html
#IBX_USER_IMPORT.rb --format documentation --out rspec.txt
#IBX_USER_IMPORT.rb --profile
#IBX_MASTER_IMPORT.rb -e laxman
<%= ENV['TEST_ENV_NUMBER'] %>