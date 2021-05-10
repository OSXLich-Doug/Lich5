require "openssl"
require "socket"

module EAccess
  PEM = File.join(__dir__, "simu.pem")
#  pp PEM
  PACKET_SIZE = 8192

  def self.download_pem()
    conn = self.socket()
    File.write(EAccess::PEM, conn.peer_cert)
    pp "wrote peer certificate to %s" % PEM
  end

  def self.verify_pem(conn)
    return if conn.peer_cert.to_s == File.read(EAccess::PEM)
    fail Exception, "\nssl peer certificate did not match #{EAccess::PEM}\nwas:\n#{conn.peer_cert}"
  end

  def self.socket(hostname = "eaccess.play.net", port = 7910)
    socket = TCPSocket.open(hostname, port)
    cert_store              = OpenSSL::X509::Store.new
    ssl_context             = OpenSSL::SSL::SSLContext.new
    ssl_context.cert_store  = cert_store
    #ssl_context.options     = (OpenSSL::SSL::OP_NO_SSLv2 + OpenSSL::SSL::OP_NO_SSLv3)
    ssl_context.verify_mode = OpenSSL::SSL::VERIFY_PEER
    cert_store.add_file(EAccess::PEM)
    ssl_socket = OpenSSL::SSL::SSLSocket.new(socket, ssl_context)
    ssl_socket.sync_close = true
    ssl_socket.connect
    return ssl_socket
  end

  def self.auth(password:, account:, character: nil, game_code: nil, legacy: false)
    conn = EAccess.socket()
    # it is vitally important to verify self-signed certs
    # because there is no chain-of-trust for them
    EAccess.verify_pem(conn)
    conn.puts "K\n"
    hashkey = EAccess.read(conn)
    #pp "hash=%s" % hashkey
    password = password.split('').map { |c| c.getbyte(0) }
    hashkey = hashkey.split('').map { |c| c.getbyte(0) }
    password.each_index { |i| password[i] = ((password[i]-32)^hashkey[i])+32 }
    password = password.map { |c| c.chr }.join
    conn.puts "A\t#{account}\t#{password}\n"
    response = EAccess.read(conn)
    unless login = /KEY\t(?<key>.*)\t/.match(response)
      eaccess_error = "Error(%s)" % response.split(/\s+/).last
      return eaccess_error
    end
    #pp "A:response=%s" % response
    conn.puts "M\n"
    response = EAccess.read(conn)
    fail Exception, response unless response =~ /^M\t/
    #pp "M:response=%s" % response

    unless legacy
      conn.puts "F\t#{game_code}\n"
      response = EAccess.read(conn)
      fail Exception, response unless response =~ /NORMAL|PREMIUM|TRIAL|INTERNAL|FREE/
      #pp "F:response=%s" % response
      conn.puts "G\t#{game_code}\n"
      EAccess.read(conn)
      #pp "G:response=%s" % response
      conn.puts "P\t#{game_code}\n"
      EAccess.read(conn)
      #pp "P:response=%s" % response
      conn.puts "C\n"
      response = EAccess.read(conn)
      #pp "C:response=%s" % response
      char_code = response.sub(/^C\t[0-9]+\t[0-9]+\t[0-9]+\t[0-9]+[\t\n]/, '')
        .scan(/[^\t]+\t[^\t^\n]+/)
        .find { |c| c.split("\t")[1] == character }
        .split("\t")[0]
      conn.puts "L\t#{char_code}\tSTORM\n"
      response = EAccess.read(conn)
      fail Exception, response unless response =~ /^L\t/
      #pp "L:response=%s" % response
      conn.close unless conn.closed?
      login_info = Hash[response.sub(/^L\tOK\t/, '')
        .split("\t")
        .map {|kv|
          k,v = kv.split("=")
          [k.downcase, v]
        }]
    else
      login_info = Array.new
      for game in response.sub(/^M\t/, '').scan(/[^\t]+\t[^\t^\n]+/)
          game_code, game_name = game.split("\t")
        #pp "M:response = %s" % response
        conn.puts "N\t#{game_code}\n"
        response = EAccess.read(conn)
        if response =~ /STORM/
          conn.puts "F\t#{game_code}\n"
          response = EAccess.read(conn)
          if response =~ /NORMAL|PREMIUM|TRIAL|INTERNAL|FREE/
            conn.puts "G\t#{game_code}\n"
            EAccess.read(conn)
            conn.puts "P\t#{game_code}\n"
            EAccess.read(conn)
            conn.puts "C\n"
            response = EAccess.read(conn)
            for code_name in response.sub(/^C\t[0-9]+\t[0-9]+\t[0-9]+\t[0-9]+[\t\n]/, '').scan(/[^\t]+\t[^\t^\n]+/)
                char_code, char_name = code_name.split("\t")
              hash = {:game_code => "#{game_code}", :game_name => "#{game_name}",
                      :char_code => "#{char_code}", :char_name => "#{char_name}"}
              login_info.push(hash)
            end
          end
        end
      end
    end
    conn.close unless conn.closed?
    return login_info
  end

  def self.read(conn)
    conn.sysread(PACKET_SIZE)
  end
end

EAccess.download_pem() if ARGV.include?("--download-pem")
