require "spec_helper"

describe Lita::Handlers::Catme, lita_handler: true do
  it { is_expected.to route_command("cat").to(:cat_me) }
  it { is_expected.to route_command("cat me").to(:cat_me) }
  it { is_expected.to route_command("cat bomb").to(:cat_bomb) }
  it { is_expected.to route_command("cat bomb 10").to(:cat_bomb) }
  it { is_expected.to route_command("cat categories").to(:cat_categories) }
  it { is_expected.to route_command("cat in boxes").to(:cat_with_category) }
  it { is_expected.to route_command("cat with sunglasses").to(:cat_with_category) }

  describe '#cat_me' do
    let(:cat) { double(url: 'https://foobar.com/cat.jpg') }
    before do
      expect(Lita::Handlers::Cat).to receive(:fetch).and_return([cat])
      send_command('cat me')
    end

    it 'writes an image url to the page' do
      expect(replies.last).to eq('https://foobar.com/cat.jpg')
    end
  end

  describe '#cat_bomb' do
    context 'when no number is passed to the command' do
      let(:cats) do
        (1..5).each_with_object([]) { |i, a| a << double(url: "https://foobar.com/cat#{i}.jpg") }
      end

      before do
        expect(Lita::Handlers::Cat).to receive(:fetch).with(count: 5).and_return(cats)
        send_command('cat bomb')
      end

      it 'sends 5 images' do
        expect(replies.length).to eq(5)
        expect(replies).to all match(URI.regexp)
      end
    end

    context 'when a number below 20 is passed to the command' do
      let(:cats) do
        (1..10).each_with_object([]) { |i, a| a << double(url: "https://foobar.com/cat#{i}.jpg") }
      end

      before do
        expect(Lita::Handlers::Cat).to receive(:fetch).with(count: 10).and_return(cats)
        send_command('cat bomb 10')
      end

      it 'sends the selected amount of images' do
        expect(replies.length).to eq(10)
        expect(replies).to all match(URI.regexp)
      end
    end

    context 'when a number above 20 is passed to the command' do
      let(:cats) do
        (1..20).each_with_object([]) { |i, a| a << double(url: "https://foobar.com/cat#{i}.jpg") }
      end

      before do
        expect(Lita::Handlers::Cat).to receive(:fetch).with(count: 20).and_return(cats)
        send_command('cat bomb 30')
      end

      it 'sends 20 images' do
        expect(replies.length).to eq(20)
        expect(replies).to all match(URI.regexp)
      end
    end
  end

  describe "#cat_categories" do
    let(:categories) { ['funny', 'boxes', 'sunglasses'] }

    before do
      expect(Lita::Handlers::Cat).to receive(:fetch_categories).and_return(categories)
      send_command('cat categories')
    end

    it 'sends an array of strings' do
      expect(replies.length).to eq(3)
      expect(replies[0]).to eq 'funny'
      expect(replies[1]).to eq 'boxes'
      expect(replies[2]).to eq 'sunglasses'
    end
  end

  describe "#cat_with_category" do
    context 'when the category is valid' do
      let(:cat) { double(url: 'https://foobar.com/cat_in_box.png') }

      before do
        expect(Lita::Handlers::Cat).to receive(:fetch).with(category: 'boxes').and_return([cat])
        send_command('cat in boxes')
      end

      it 'sends an image url' do
        expect(replies.last).to eq('https://foobar.com/cat_in_box.png')
      end
    end

    context 'when the category is valid' do
      before do
        expect(Lita::Handlers::Cat).to receive(:fetch).with(category: 'foobar').and_return([])
        send_command('cat in foobar')
      end

      it 'displays an error message' do
        expect(replies.last).to eq('Enter a valid category (type "cat categories" for a list of valid categories)')
      end
    end
  end
end
