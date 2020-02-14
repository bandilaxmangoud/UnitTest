 
describe 'check for SQL SERVER instanace and Version' do
 
 # An example of using helper method sproc.
  it 'is hosted on a SQL Server instance' do
    # Call sp_server_info using helper method sproc.
    result = sproc('sp_server_info')

    # sp_server_info returns a single resultset with server attributes.
    expect(result.count).to be > 1

    # Convert the returned resultset to a hash of server attributes.
    server_attributes = result.map{|r| [r[:attribute_name], r[:attribute_value]]}.to_h

    expect(server_attributes['DBMS_NAME']).to be == 'Microsoft SQL Server'
    expect(server_attributes['DBMS_VER']).to be == 'Microsoft SQL Server 2017 - 14.0.1000.169'
    
  end

end