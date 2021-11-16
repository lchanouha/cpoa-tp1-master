# -*- coding: utf-8 -*-
# usage: ruby checkModel.rb
# -------------------
# Author::    Jean-Michel Bruel  (mailto:jbruel@gmail.com) improved by JMI
# Copyright:: Copyright (c) 2014--2021 JMB
# License::   Distributes under the same terms as Ruby
# -------------------

require "minitest/autorun"
MODEL_NAME = "model.uml"

module MiniTest
  class Unit
    class TestCase
      #Define new assertion
      def assert_contains(string_to_test, substring_to_verify)
        assert_match( string_to_test, substring_to_verify)
      end
      def assert_not_contains(string_to_test, substring_to_verify)
        assert_not_match( string_to_test, substring_to_verify)
      end
    end
  end
end
MiniTest::Unit.after_tests { p @_assertions }

class TestGeneratedModel < MiniTest::Unit::TestCase
  #------------ General tests about plantUML
  def test_generated_model_exists
    print assert_equal(true, File.exists?(MODEL_NAME))
  end

  def test_generated_model_is_plantuml
    assert_equal(true, File.readlines(MODEL_NAME).grep(/@startuml/).any?)
    assert_equal(true, File.readlines(MODEL_NAME).grep(/@enduml/).any?)
  end

  def test_generated_model_exists
    assert_equal(true, File.exists?(MODEL_NAME))
  end

  #------------ Specific tests about expected content
  def test_class_Canard_is_abstract
    assert_equal(true, File.readlines(MODEL_NAME).grep(/abstract Canard/).any?)
  end

  def test_class_Canard_has_ComportementCancan_behavior
    assert_contains(/Canard\s+--> ".*" ComportementCancan/, File.readlines(MODEL_NAME).join)
  end

  def test_class_Canard_has_ComportementVol_behavior
    assert_contains(/Canard\s+--> ".*" ComportementVol/, File.readlines(MODEL_NAME).join)
  end

  def test_ComportementCancan_is_an_Interface
    assert_equal(true, File.readlines(MODEL_NAME).grep(/interface\s+ComportementCancan/).any?)
  end

  def test_ComportementVol_is_an_Interface
    assert_equal(true, File.readlines(MODEL_NAME).grep(/interface\s+ComportementVol/).any?)
  end

  def test_ComportementCancan_Interface_has_concrete_implementation
    assert_equal(true, File.readlines(MODEL_NAME).grep(/ComportementCancan\s+<\|\.\./).any?)
  end

  def test_ComportementVol_Interface_has_concrete_implementation
    assert_equal(true, File.readlines(MODEL_NAME).grep(/ComportementVol\s+<\|\.\./).any?)
  end

end
