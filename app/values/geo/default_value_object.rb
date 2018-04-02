module Geo::DefaultValueObject
  def self.call
    [{"description"=>"New York, NY, United States",
      "place_id"=>"ChIJOwg_06VPwokRYv534QaPC8g",
      "terms"=>
        [{"offset"=>0, "value"=>"New York"},
         {"offset"=>10, "value"=>"NY"},
         {"offset"=>14, "value"=>"United States"}],
      "types"=>["locality", "political", "geocode"]},
     {"description"=>"London, United Kingdom",
      "place_id"=>"ChIJdd4hrwug2EcRmSrV3Vo6llI",
      "terms"=>
        [{"offset"=>0, "value"=>"London"},
         {"offset"=>8, "value"=>"United Kingdom"}],
      "types"=>["locality", "political", "geocode"]},
     {"description"=>"Barcelona, Spain",
      "place_id"=>"ChIJ5TCOcRaYpBIRCmZHTz37sEQ",
      "terms"=>
        [{"offset"=>0, "value"=>"Barcelona"}, {"offset"=>11, "value"=>"Spain"}],
      "types"=>["locality", "political", "geocode"]},
     {"description"=>"Moscow, Russia",
      "place_id"=>"ChIJybDUc_xKtUYRTM9XV8zWRD0",
      "terms"=>
        [{"offset"=>0, "value"=>"Moscow"}, {"offset"=>8, "value"=>"Russia"}],
      "types"=>["locality", "political", "geocode"]}]
  end
end
