json.array! @doorbot_members.map(&:to_builder).map(&:target!)
