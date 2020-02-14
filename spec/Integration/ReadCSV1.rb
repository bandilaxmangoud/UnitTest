describe 'SP_IG_Import_MasterData' do

    it 'load csv file' do

        CSV.foreach("data//inputData//IBX_CostCenter.csv") do |row|
            #I'm assuming ID is the first element in each row
           puts id = row.first
                   
            # assert that stuff has happened ...
          end
                  
    end
end