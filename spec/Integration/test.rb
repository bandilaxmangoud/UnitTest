require 'nokogiri' 

describe 'validating CostCenter master file scenarios' do     
   
    before do
    
        @int = [87]

        @mspid = 13
        @clientid = 87
        @jobmastersettingid = 17

        doc = File.open("data//inputData//IBX_CostCenter_Data.xml") { |f| Nokogiri::XML(f) }
        result = sproc("SP_IG_Import_MasterData",
                :mspID => @mspid,
                :clientID => @clientid, 
                :XmlData => doc.to_s, 
                :jobMasterSettingId => @jobmastersettingid)
    end

        
    it "creates a new record" do
        
       
        @int.each do |x|
        expect(x).to eql(@clientid)
        
        puts x
        end

        res = query( "select CostCenterNumber,CostCenterName 
                      from ST_PM_CostCenterMaster 
                      where CostCenterNumber = 'Test00100'
                      and clientid = 87" )
        
        expect(res[0][:"CostCenterNumber"].to_s).to be == "Test00100"
        puts "created new record with 
        CostCenterNumber is: #{res[0][:"CostCenterNumber"].to_s}
        and CostCenterName is: #{res[0][:"CostCenterName"].to_s}" 

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


end