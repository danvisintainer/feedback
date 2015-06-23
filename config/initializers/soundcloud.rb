# create client object with app credentials
SOUNDCLOUD_CLIENT = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'],
                        :client_secret => ENV['SOUNDCLOUD_SECRET'],
                        :redirect_uri => 'http://127.0.0.1:3000/auth/soundcloud')

