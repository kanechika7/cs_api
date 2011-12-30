# coding: UTF-8

# controller spec
# @author Nozomu Kanechika
# @since 0.0.1

require 'spec_helper'

describe CsApi::Controller do
  let(:user_controller) { UsersController.new }
  subject { user_controller }

  # instance methods
  it("define cs_required"){ should respond_to :cs_required }
  it("define cs_role_required"){ should respond_to :cs_role_required }
end
