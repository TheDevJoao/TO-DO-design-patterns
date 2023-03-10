# frozen_string_literal: true

RSpec.describe TaskCreator do
  describe '.call' do
    let(:user) { create(:user) }
    let(:status) { :pending }
    let(:name) { 'Task name' }

    context 'when parameters are valid' do
      subject(:task) { described_class.call(user:, status:, name:) }

      it 'creates task' do
        expect(task.success?).to be true
      end
    end

    context 'when parameters are invalid' do
      subject(:task) { described_class.call(user: nil, status: nil, name: nil) }

      it 'fails to create a task' do
        expect(task.success?).to be false
      end
    end
  end
end
