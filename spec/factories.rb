FactoryGirl.define do
	factory :user do
		name "Alex"
		email "alex@email.com"
		password "foobar"
		password_confirmation "foobar"
	end
end