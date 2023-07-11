class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: { :minimum => 250}
    validates :summary, length: { :maximum => 250}
    validates :category, inclusion:  ['Fiction', 'Non-Fiction']

    validate :is_click_bait?

    CLICKBAIT_PATTERNS = [
        /Won't Believe/i,
        /Secret/i,
        /Top \d/i,
        /Guess/i
    ]

    def is_click_bait?
        if CLICKBAIT_PATTERNS.none? { |pat| pat.match title}
            errors.add(:title, "must be clickbait")
        end
    end
end
