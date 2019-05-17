require "sk_progress_bar/version"

module SkProgressBar

  def self.division_by_cycle(object_count)
    return unless object_count.present? && object_count.positive?
    (100 / object_count)
  end

  # Update Progress Bar
  def self.update_progress_bar(percentage, message, jid=nil)
    ActionCable.server.broadcast 'sk_progress_bar_channel',
                                 message:  message,
                                 sk_process_id: jid,
                                 progress_status: percentage
  end

  # Return Percentage and Message result of cycle
  def self.progress_status(cycle_index, objects_count)
    percentage = (cycle_index + 1) * division_by_cycle(objects_count)
    message = percentage == 100 ? 'Done' : 'Almost done'
    { percentage: percentage, message: message }
  end

  # Add/Update record in ProgressBar table
  def self.create_update_db(percentage, message, jid=nil)
    return unless !!defined?(ProgressBar)

    db_record = jid.present? ? ProgressBar.find_by(sk_process_id: jid[:jid]) : nil
    if db_record.present?
      db_record.update( message: message, sk_process_id: jid[:jid], percentage: percentage )
    else
      new_record = ProgressBar.new( message: message, sk_process_id: jid[:jid], percentage: percentage )
      new_record.save
    end
  end
end