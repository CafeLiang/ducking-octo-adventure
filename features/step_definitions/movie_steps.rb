# Add a declarative step here for populating the DB with movies.
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
 # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.

  page.body.index(e1).should < page.body.index(e2)
  #page.body =~ /#{e1}.*#{e2}/
  #flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(', ')

  ratings.each do |rating|
    steps %Q{When I #{uncheck}check "ratings[#{rating}]"}
    end 
#  flunk "Unimplemented"
end

Then /I should( not)? see all the movies in ratings: (.*)/ do |shouldnt, rating_list|
  ratings = rating_list.split(', ')
  ratings.each do |rating|
    Movie.where('rating' => rating).each do |movie|
      steps %Q{Then I should#{shouldnt} see "#{movie[:title]}"}
    end
  end
end

Then /I should see all the movies$/ do
  # Make sure that all the movies in the app are visible in the table
 page.all('table#movies tbody tr').count.should == Movie.count

#page.should have_css('table#movies tbody tr', :count=> 10)

  #flunk "Unimplemented"
end


