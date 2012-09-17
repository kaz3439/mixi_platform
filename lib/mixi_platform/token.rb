# Copyright (c) 2012, mixi, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#  * Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#  * Neither the name of the mixi, Inc. nor the names of its contributors may
#    be used to endorse or promote products derived from this software without
#    specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.
# IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

require_relative 'oauth'

#
# = app/models/graph_api/client/people.rb - Access Token, Refresh Tokenを管理するクラス
#

module MixiPlatform

  #
  #
  # = Description
  # ActiveRecordを使ってTokenを管理する
  # 
  # = USAGE
  # #tokenを新規に取得する
  # MixiPlatform::OAuth.configure do |config|
  #   config.consumer_key    = "a_consumer_key" 
  #   config.consumer_secret = "a_consumer_secret" 
  #   config.redirect_url    = "a_redirect_url" 
  # end
  # MixiPlatform::Token.new("gedafeg")
  #
  # #tokenが有効期限切れだった場合リフレッシュする
  # token.refresh! if token.expired?
  #
  class Token
    attr_accessor :access_token, :expires_in, :refresh_token, :updated_at, :oauth

    # Tokenを新規に取得する
    # ---
    # *Arguments*
    # (required) authorization_code: String    
    def initialize(authorization_code)
      token_hash = OAuth.create_token(authorization_code)
      raise MixiPlatform::HTTPError, token_hash['error'] if token_hash.has_key? 'error'
      @access_token  =  token_hash['access_token']
      @refresh_token = token_hash['refresh_token']
      @expires_in    = token_hash['expires_in']
      @updated_at    = Time.now
    end

    # Access Tokenが有効期限切れかどうかチェックする
    # ---
    # *Returns*:: Boolean
    def expired?
      (Time.now - self.updated_at) > expires_in
    end
  
    # Tokenを更新する
    # ---
    def refresh!
      token_hash = OAuth.refresh_token(self.refresh_token)
      raise IOError, token_hash['error'] if token_hash.has_key? 'error'
      @access_token =  token_hash['access_token']
      @refresh_token = token_hash['refresh_token']
      @expires_in = token_hash['expires_in']
      @updated_at = Time.now
    end

  end #Token
end #MixiPlatform
