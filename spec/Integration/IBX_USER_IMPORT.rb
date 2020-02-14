require 'nokogiri' 

describe 'validating user file scenarios' do
    
        before do
            doc = File.open("data//inputData//IBX_User_Data.xml") { |f| Nokogiri::XML(f) }
            sp1 = sproc("SP_ST_IG_GENERIC_IMPORTEMPLOYEELIST", :mspID => 13, :clientID => 87, :XmlData => doc.to_s)
            sp2 = sproc("SP_ST_IG_GENERIC_EMPUSERROLERIGHTINSUPDATE", :mspID => 13, :clientID => 87)
            sp3 = sproc("SP_ST_IG_GENERIC_EMPUSERASSOCIATION", :mspID => 13, :clientID => 87)
            #sp4 = sproc("SP_ST_IG_GENERIC_HIERARCHY", :mspID => 13, :clientID => 87)
            #sp5 = sproc("ST_MS_DFS_HierarchyLevel", :mspID => 13, :clientID => 87)
            #sp6 = sproc("ST_LM_Insert_Integration_Userhistory", :mspID => 13, :clientID => 87, :timezoneid => 0)
        end
    
    
        it "creates a new record" do 
            res = query( "select email,empid,statusid 
                          from ST_LM_User 
                          where empid = '102220'
                          and clientID = 87" )
                       
            expect(res[0][:"email"].to_s).to be == "MARK.WRIGHT1@hcmondemand.net"
            expect(res[0][:"empid"].to_s).to be == "102220"
            expect(res[0][:"statusid"]).to be == 1
            
            puts "Created new record with 
            empid as: #{res[0][:"empid"].to_s},
            email as: #{res[0][:"email"].to_s},
            and statusID as: #{res[0][:"statusid"]}"       
        end

    
        it "does not creates a record with duplicate EMPID" do
            res = query( "select empid 
                          from ST_LM_User 
                          where empid = '102220'
                          and clientID = 87" )
    
            expect(res.count).to eql (2)
            puts 'skipping record with duplicate EMPID'   
        end
    
    
        it "does not create a record with duplicate EMAILID" do 
            res = query( "select email 
                          from ST_LM_User 
                          where email = 'MARK.WRIGHT1@hcmondemand.net'
                          and clientID = 87" )
    
            expect(res.count).to eql (2)
            puts 'skipping record with duplicate EmailID' 
        end
    
    
        it "Validate the USER ROLE" do           
            res = query( "select roleName 
                          from ST_LM_Role r 
                          inner join ST_LM_UserRole ur
                          on r.roleID = ur.roleID
                          inner join ST_LM_User u
                          on u.userID = ur.userID
                          where r.clientid = 87 and 
                          u.empid = '102220'" )
    
            expect(res[0][:"roleName"]).to be == "Primary Manager"
            puts "assigned user role is: #{res[0][:"roleName"]}"
        end
    
    
        it "does not creates a record with blank EMPID" do
            res = query( "select empid
                          from ST_LM_User 
                          where email = 'user_fname1.lname1@hcmondemand.net'
                          and clientID = 87" )
    
            expect(res).to be_empty
            puts 'skipping record with blank EMPID'
        end
    
    
        it "does not creates a record with blank FirstName" do
            res = query( "select empid 
                          from ST_LM_User 
                          where empid = '10002'
                          and clientID = 87" )
    
            expect(res).to be_empty
            puts 'skipping record with blank FirstName'
        end
    
    
        it "does not creates a record with blank LastName" do
            res = query( "select empid 
                          from ST_LM_User 
                          where empid = '10003'
                          and clientID = 87" )
    
            expect(res).to be_empty
            puts 'skipping record with blank LastName'
        end
    
        it "does not creates a record with blank EmailID" do
            res = query( "select empid 
                          from ST_LM_User 
                          where empid = '10004'
                          and clientID = 87" )
    
            expect(res).to be_empty
            puts 'skipping record with blank EmailID'
        end
    
        it "does not creates a record with blank UserRole" do
            res = query( "select empid
                          from ST_LM_User 
                          where empid = '10005' 
                          and clientID = 87" )
    
            expect(res).to be_empty
            puts 'skipping record with blank UserRole'
        end
           
        it "creates a record with optional fields are blank" do
            res = query( "select email,empid,statusid 
                          from ST_LM_User 
                          where  empid = '10006'
                          and clientID = 87" )
    
            expect(res[0][:"email"].to_s).to be == "user_fname6.lname6@hcmondemand.net"
            puts "Created new record with optional fields are blank
            empid as: #{res[0][:"empid"].to_s},
            email as: #{res[0][:"email"].to_s},
            and statusID as: #{res[0][:"statusid"]}"
        end
    
    
        it "updates the FirstName" do
            res = query( "select firstName 
                          from ST_LM_User 
                          where  empid = '28550'
                          and clientID = 87" )
    
            expect(res[0][:"firstName"].to_s).to be == "Lovitz1"
            puts "updated FirstName as: #{res[0][:"firstName"].to_s}"
        end
    
    
        it "updates the LastName" do
            res = query( "select lastName 
                          from ST_LM_User 
                          where  empid = '29252'
                          and clientID = 87" )
    
            expect(res[0][:"lastName"].to_s).to be == "Thomas2"
            puts "updated LastName as: #{res[0][:"lastName"].to_s}"
        end
    
        it "updates the Email" do
            res = query( "select email 
                          from ST_LM_User 
                          where  empid = '7470'
                          and clientID = 87" )
    
            expect(res[0][:"email"].to_s).to be == "JULIA.HARTNETT3@hcmondemand.net"
            puts "updated email as: #{res[0][:"email"].to_s}"
        end

    
        it "updates the UserRole" do
            res = query( "select roleName 
                          from ST_LM_Role r 
                          inner join ST_LM_UserRole ur
                          on r.roleID = ur.roleID
                          inner join ST_LM_User u
                          on u.userID = ur.userID
                          where r.clientid = 87 and 
                          u.empid = '9934'" )

            expect(res[0][:"roleName"]).to be == "Super Program Admin"
            puts "updated user role as: #{res[0][:"roleName"]}"
        end
    

        it "creates the User Associations" do
            res = query( "select U.empid, U.email, CM.CostCenterNumber, CM.CostCenterName,
                          HM.parentID, HM.parentFieldID, HM.hierarchyFieldID,HM.hierarchyFieldValue
                          from ST_PM_HMRelatedFieldHierarchyMaster as HM
                          inner join ST_PM_COSTCENTERMASTER as CM on  HM.hierarchyFieldValue = CM.CostCenterId
                          inner join ST_LM_USER as U on U.userID = HM.parentFieldID
                          where hm.clientID=87 
                          and u.empid = '120334'" )
                         
            expect(res[0][:"empid"]).to be == "120334"
            expect(res[0][:"CostCenterNumber"]).to be == "83111"
            puts "User Association details are:
                  EMP ID: #{res[0][:"empid"]},
                  EMAIL ID: #{res[0][:"email"]},
                  CostCenterNumber: #{res[0][:"CostCenterNumber"]},
                  CostCenterName: #{res[0][:"CostCenterName"]},
                  ParentID: #{res[0][:"parentID"]},
                  HierarchyFieldID: #{res[0][:"hierarchyFieldID"]}"    
        end
       
    end