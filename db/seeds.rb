# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
PromptCategory.create(moniker: "theme_insights")
PromptCategory.create(moniker: "game_basics")
PromptCategory.create(moniker: "world_connections")

ImpactArea.create(name: "Educational Relevancy")
ImpactArea.create(name: "Economic Prosperity")
ImpactArea.create(name: "Engaged Citizenship")
ImpactArea.create(name: "Environmental Sustainability")
ImpactArea.create(name: "Public Health")
ImpactArea.create(name: "Cultural Emergence")
