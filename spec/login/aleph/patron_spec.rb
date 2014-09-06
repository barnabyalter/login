require 'spec_helper'
module Login
  module Aleph
    describe Patron do
      let(:identifier) { ENV["TEST_ALEPH_USER"] || 'BOR_ID' }
      let(:status) { '01' }
      let(:type) { 'TP' }
      let(:ill_permission) { 'Y' }
      let(:college) { 'College' }
      let(:department) { 'Department' }
      let(:major) { 'Major' }
      let(:plif_status) { 'PLIF_LOADED' }
      let(:patron_hash) {
        {
          identifier: identifier,
          status: status,
          type: type,
          ill_permission: ill_permission,
          college: college,
          department: department,
          major: major,
          plif_status: plif_status
        }
      }
      subject (:patron) do
        Patron.new do |patron|
          patron.identifier = identifier
          patron.status = status
          patron.type = type
          patron.ill_permission = ill_permission
          patron.college = college
          patron.department = department
          patron.major = major
          patron.plif_status = plif_status
        end
      end
      it { should be_a Patron }
      describe '#identifier' do
        subject { patron.identifier }
        it { should eq identifier }
      end
      describe '#status' do
        subject { patron.status }
        it { should eq status }
      end
      describe '#type' do
        subject { patron.type }
        it { should eq type }
      end
      describe '#ill_permission' do
        subject { patron.ill_permission }
        it { should eq ill_permission }
      end
      describe '#college' do
        subject { patron.college }
        it { should eq college }
      end
      describe '#department' do
        subject { patron.department }
        it { should eq department }
      end
      describe '#major' do
        subject { patron.major }
        it { should eq major }
      end
      describe '#plif_status' do
        subject { patron.plif_status }
        it { should eq plif_status }
      end
      describe '#to_h' do
        subject { patron.to_h }
        it { should include patron_hash }
      end

      context 'when initialized without a block' do
        subject { Patron.new }
        it 'should raise an ArgumentError' do
          expect{ subject }.to raise_error ArgumentError
        end
      end
    end
  end
end
