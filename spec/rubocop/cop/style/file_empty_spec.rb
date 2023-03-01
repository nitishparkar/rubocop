# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Style::FileEmpty, :config do
  let(:config) { RuboCop::Config.new }

  it 'registers an offense when using `File.zero?`' do
    expect_offense(<<~RUBY)
      File.zero?
      ^^^^^^^^^^ Use `File.empty?` instead of `File.zero?`.
    RUBY
  end

  it 'does not register an offense when using `File.empty?`' do
    expect_no_offenses(<<~RUBY)
      File.empty?
    RUBY
  end

  it 'corrects `File.zero?`' do
    expect_offense(<<~RUBY)
      File.zero?
      ^^^^^^^^^^^^^ Use `File.empty?` instead of `File.zero?`.
    RUBY

    expect_correction(<<~RUBY)
      File.empty?
    RUBY
  end
end
