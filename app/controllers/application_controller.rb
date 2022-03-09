class ApplicationController < ActionController::Base

  def error_message(errors)
    errors.full_messages.join(', ')
  end
  
  # def repo_name
  #   @repo_name = RepoNameFacade.find_repo_name
  # end
  #
  # def contributors
  #   @contributors = ContributorFacade.find_contributor
  # end
  #
  # def pulls
  #   @pulls = PullsFacade.count_pulls
  # end
end
