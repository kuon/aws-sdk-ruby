# Copyright 2011-2013 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

require 'test_helper'

module Seahorse
  describe Client do

    def api
      { 'endpoint' => 'http://endpoint:123' }
    end

    def client_class
      Client.define(api)
    end

    it 'defines a semver compatible version' do
      Client::VERSION.must_match(/\d+\.\d+\.\d+/)
    end

    describe '#config' do

      it 'returns a configuration object' do
        client = client_class.new
        client.config.must_be_kind_of(Client::Configuration)
      end

    end

    describe '#endpoint' do

      it 'is an Endpoint object' do
        client_class.new.endpoint.must_be_kind_of(Client::Endpoint)
      end

      it 'is built from the :endpoint constructor option' do
        client_class = Client.define({})
        client = client_class.new(:endpoint => 'foo.com')
        client.endpoint.must_equal('https://foo.com')
      end

      it 'comes from the client class API when not passed to the constructor' do
        client_class = Client.define('endpoint' => 'http://foo.com')
        client = client_class.new
        client.endpoint.must_equal('http://foo.com')
      end

    end

    describe '.define' do

      it 'creates a new client class' do
        client_class = Client.define({})
        client_class.ancestors.must_include(Client)
      end

    end

    describe '.api' do

      it 'returns the API passed to .define' do
        api = {}
        client_class = Client.define(api)
        client_class.api.must_be_same_as(api)
      end

    end

  end
end
