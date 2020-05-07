class BaseInteractor < ActiveInteraction::Base
  def merging_errors(in_transaction: true)
    block = -> do
      object = yield

      unless object&.errors.empty?
        errors.merge! object.errors
        raise ActiveRecord::Rollback if in_transaction
      end

      object
    end

    if in_transaction
      ApplicationRecord.transaction(&block)
    else
      block.call
    end
  end
end
