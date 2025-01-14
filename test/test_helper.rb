# frozen_string_literal: true

# MiniTest Assertions. All assertion methods accept a msg which is printed if the assertion fails.
# https://docs.ruby-lang.org/en/2.1.0/MiniTest/Assertions.html

# skipped?()

# assert(test, msg = nil)
# assert_empty(obj, msg = nil)
# assert_equal(exp, act, msg = nil)
# assert_instance_of(cls, obj, msg = nil)
# assert_kind_of(cls, obj, msg = nil)
# assert_nil(obj, msg = nil)

# refute(test, msg = nil)
# refute_empty(obj, msg = nil)
# refute_equal(exp, act, msg = nil)
# refute_instance_of(cls, obj, msg = nil)
# refute_kind_of(cls, obj, msg = nil)
# refute_nil(obj, msg = nil)

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "market_hub"

require "minitest/autorun"

# GLOBAL TOKEN VARIABLES
# Configure valid tokens so that the tests can be carried out successfully.
@@meli_access_token = 'APP_USR-7241495617113935-031508-84aabf5bb3a5836ac7eb5bd789feb5e5-1632856741'
@@meli_user_id = '1632856741'
@@meli_item_id = 'MLB4389178328'
@@meli_order_id = '2000007487844160'
@@meli_shipment_id = '43054715141'
