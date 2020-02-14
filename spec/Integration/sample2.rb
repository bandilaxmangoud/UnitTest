
describe 'SP_IG_Import_MasterData' do
        
    it "should create a new user" do

      data = CSV.parse(<<~ROWS, headers: true)
        Name,Department,Salary
        Bob,Engineering,1000
        Jane,Sales,2000
        John,Management,5000
      ROWS

      puts data.class
      puts data.first
      puts data.first.to_h
          
   end
  
end