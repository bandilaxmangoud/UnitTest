require 'csv'
describe 'Read CSV File' do

    it 'load csv file' do

        data = CSV.parse(File.read("data//inputData//IBX_CostCenter.csv"), :col_sep => "|")
        #data.each
        puts data
        
     
       
    end
end