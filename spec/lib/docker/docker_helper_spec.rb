require 'rails_helper'

describe Docker::DockerHelper do
  let(:helper){ Docker::DockerHelper }

  describe "self.get_db_config" do
    subject{ helper.get_db_config env }
    let(:env_const) do
      {
        'LOGIN_DB_USER' => 'user',
        'LOGIN_DB_PASSWORD' => 'pass',
        'LOGIN_DB_DATABASE' => 'data',
        'test' => {
          'LOGIN_DB_USER' => 'wsops',
        },
      }
    end

    before do
      allow(Figs).to receive(:env).and_return env_const
    end

    context "for development" do
      let(:env){ "development" }

      it { should be_a Hash }
      it "should include docker postgres variable for ENV default user when no environment-specific" do
        expect(subject[:POSTGRES_USER]).to eq "user"
      end
      it "should include docker postgres variable for ENV default password when no environment-specific" do
        expect(subject[:POSTGRES_PASSWORD]).to eq "pass"
      end
      it "should include docker postgres variable for ENV default password when no environment-specific" do
        expect(subject[:POSTGRES_DB]).to eq "data"
      end

      context "without ENV-defined value" do
        let(:env_const) do
          {
            'test' => {
              'LOGIN_DB_USER' => 'wsops',
            },
          }
        end

        it "should include docker postgres variable for default database user" do
          expect(subject[:POSTGRES_USER]).to eq "login"
        end
        it "should include docker postgres variable for default database password" do
          expect(subject[:POSTGRES_PASSWORD]).to eq ""
        end
        it "should include docker postgres variable for default database name" do
          expect(subject[:POSTGRES_DB]).to eq "login_development"
        end
      end
    end

    context "for test" do
      let(:env){ "test" }

      it { should be_a Hash }
      it "should include docker postgres variable for ENV environment-specific user" do
        expect(subject[:POSTGRES_USER]).to eq "wsops"
      end
      it "should include docker postgres variable for ENV default password when no environment-specific" do
        expect(subject[:POSTGRES_PASSWORD]).to eq "pass"
      end
      it "should include docker postgres variable for ENV default password when no environment-specific" do
        expect(subject[:POSTGRES_DB]).to eq "data"
      end
    end


  end
end
