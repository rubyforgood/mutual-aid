require 'rails_helper'

RSpec.describe HtmlSanitizer, type: :model do
  let(:sanitizer) { described_class.new(string) }
  let(:partial_whitelist) { %w[b br h1 div span ol ul li] }

  describe "#sanitize_for_rails" do
    subject { sanitizer.sanitize_for_rails }

    let(:string) do
      %Q{
      <div class="title is-3">About us</div>
      <script>alert('I did something bad!');</script>
      <ul>
        <ol>
          <li>
            <h1 class='title is-5'>What is Mutual Aid?</h1>
            <br><br>
            <span class="has-text-weight-bold">Mutual Aid is</span> <b>neighbors supporting neighbors<b> in the spirit of solidarity to meet survival needs, as opposed to non-profit/charity or government work where people are dependent on a central organization. We recognize that <span class="has-text-weight-bold">the community knows best</span> what its needs are and how to meet them.
            <br><br>
            <span class="has-text-weight-bold">Mutual Aid</span> supports all our neighbors, but we recognize current and historical oppression and want to prioritize meeting the needs of our most vulnerable neighbors including <span class="has-text-weight-bold has-text-italic">the poor, sick, elderly, disabled, undocumented, LGBTQ+, Black, Brown, Indigenous and/or people of color.</span>
            <br><br>
            <span class="has-text-weight-bold">Mutual Aid</span> is political and anti-oppressive by nature, and focused on creating <span class="has-text-weight-bold has-text-italic">long-term, sustainable systems of interdependent community care</span> that ultimately lead to a more resilient and self-reliant region. We want to foster a culture of collectivism in the Greater Glens Falls area that operates outside individualism and existing government and non-profit systems.
            <br><br><br><br>
          </li>
      
          <li>
            <span class='title is-5'>Why is Mutual Aid necessary?</span>
            <br><br>
            <span class="has-text-weight-bold">Mutual Aid</span> fills gaps. It is homegrown and grassroots. It protects the privacy of people who are asking and people who are giving. No strings are attached, in order to avoid power dynamics. It levels the playing field and honors all people. It connects people to existing resources and meets a need for those who fall through the cracks. It supports and strengthens existing organizations.
            <br><br>It is central, human-focused, and, at its roots, it is <span class="has-text-weight-bold">ANTI-OPPRESSION</span>.
      <br><br><br><br>
          </li>
      
          <li>
            <span class='title is-5'>What are the foundations of Mutual Aid?</span>
            <br><br>
            <ol>
              <li>Cooperation, not competition</li>
              <li>Non-hierarchical, non-bureaucratic </li>
              <li>Egalitarian</li>
              <li>Non-discriminatory</li>
              <li>Giving is with no strings attached & no expectations</li>
              <li>Solidarity, not charity</li>
              <li>Mutual aid is offered to anyone, not only those who meet criteria for assistance and are deemed worthy/needy/deserving</li>
            </ol>
            <br><br><br><br>
          </li>
      
          <li>
            <span class='title is-5'>What do volunteers do?</span>
            <br><br>
            <ul>
              <li>Build our community resource list, collecting info about what already exists</li>
              <li>Train other volunteers</li>
              <li>Bring needs to the group’s attention and help address those needs</li>
              <li>Organize events and advocacy </li>
              <li>Volunteers are needed on an ongoing basis to make matches and dispatch offerings to needs. This means logging in to the software, making matches, sending texts and emails and making phone calls, and logging notes. </li>
              <li>Participate in Slack, the Facebook Group and/or meetings to keep in the loop</li>
            </ul>
            <br><br><br><br>
          </li>
        </ol>
      </ul>
    }
    end
    it 'removes dangerous tags' do
      expect(subject).not_to match('<script>')
    end

    it 'leaves whitelisted tags' do
      partial_whitelist.each do |whitelisted_tag|
        expect(subject).to match("<#{whitelisted_tag}[ >]")
      end
    end

    it 'keeps span and div attributes' do
      expect(subject).to include("<span class=\"has-text-weight-bold\">")
      expect(subject).to include("<div class=\"title is-3\">")
    end
  end
end
