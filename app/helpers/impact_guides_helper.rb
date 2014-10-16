module ImpactGuidesHelper

    def impactAreaName(x)
      @q = ImpactArea.find_by(id: x)
      return @q
    end
    
end
