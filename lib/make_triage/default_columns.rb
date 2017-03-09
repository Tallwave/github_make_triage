module MakeTriage
  def self.default_columns
    [
      "Received",
      "Triaged",
      "Scheduled",
      "In Progress",
      "Ready for Test",
      "Testing",
      "Ready to Deploy",
      "Done"
    ]
  end
end
