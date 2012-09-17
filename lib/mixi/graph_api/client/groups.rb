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

#
# = mixi4ruby/graph_api/client/groups.rb - Groups API用クラス
#
# *Reference* 
#  http://developer.mixi.co.jp/connect/mixi_graph_api/mixi_io_spec_top/groups-api/

require_relative 'base'

module Mixi
  module GraphApi
    module Client
  
      #
      #
      # = Description
      # Groups APIを叩くためのクラス
      #
      # = USAGE
      # #ユーザのTokenを渡して初期化する
      # token = Mixi::GraphApi::Client::Token.create_by_user_id([USER_ID])
      # token.get!([AUTHORIZATION_CODE])
      # groups = Mixi::GraphApi::Client::Groups.new(token)
      #
      # #グループ一覧を取得する
      # groups = groups.lookup_my_groups
      #
      class Groups < Mixi::GraphApi::Client::Base
  
        ENDPOINT_PREFIX = '/2/groups'
  
        # ユーザのグループ一覧を取得
        # ---
        # *Returns*:: JSONレスポンス: Hash
        def get_my_groups(args={})
          endpoint = "#{ENDPOINT_PREFIX}/#{ME}"
          get(endpoint, args)
        end
  
        # ユーザが登録しているグループ名のみを一覧で取得
        # ---
        # *Returns*:: JSONレスポンス: Hash
        def lookup_my_groups
          get_my_groups
        end
  
        # ユーザが登録しているグループ一覧とその所属メンバーを取得
        # ---
        # *Returns*:: JSONレスポンス: Hash
        def get_my_groups_with_members
          get_my_groups({paras: {fields: "members"}})
        end
  
        # ユーザが登録しているあるグループの取得
        # ---
        # *Returns*:: JSONレスポンス: Hash
        def get_a_group(group_id)
          endpoint = "#{ENDPOINT_PREFIX}/#{ME}/#{group_id}"
          get(endpoint)
        end
  
        # グループを作成
        # ---
        # *Arguments*
        # (required) title: String
        # (required) members: String (User IDs)
        # *Returns*:: JSONレスポンス: Hash
        def create_a_group(title, members=[])
          endpoint = "#{ENDPOINT_PREFIX}/#{ME}"
          args = {params: {title: title, members: members}}
          post(endpoint, args)
        end
  
      end #Groups
    end #Client
  end #GraphApi
end #Mixi
