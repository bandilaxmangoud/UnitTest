require 'nokogiri'
describe 'SP_IG_Import_MasterData' do
        
     it "should create a new user" do
 
        f = File.open("C:\\Users\\Laxman.Bandi\\Desktop\\ibxData.xml")
        doc = Nokogiri::XML(f)
       #puts doc
        rows = []
        doc.xpath('/*/*').each do |row_xml|
         row_values = []
         rows << row_values
  
         row_xml.xpath('./*').each do |field|
           row_values << field.text
         end
         puts row_values
         
    
        end
        #require 'pp'
            #pp rows
            #rows = doc.xpath('/*/*').map{ |row| row.xpath('./*').map(&:text) }
            #columns = doc.xpath('/*/*[position()=0]/*').map(&:name)
            #puts rows

            data=[{:id=>"SD0005", :required=>"yes"},{:id=>"SD0006", :required=>"no"}]
            def valid_id?(id_string)
                !!id_string.match(/^[\D|\d]{6}$/)
            end
            def valid_required?(req_column)
                req_column.downcase == 'yes' ||   req_column.downcase == 'no'
            end
            def all_valid?(row)
                valid_id?(row[:id]) && valid_required?(row[:required])
              end
              valid_records = data.select { |record| all_valid?(record) }
              #puts valid_records
        

    end
     
end