# spec/models/movie_spec.rb
 
describe Movie do
  it 'should include rating and year in full name' do
    movie = FactoryGirl.build(:movie, :title => 'Milk', :rating => 'R')
    movie.name_with_rating.should == 'Milk (R)'
  end
end
 
