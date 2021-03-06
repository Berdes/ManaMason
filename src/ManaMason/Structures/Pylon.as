package ManaMason.Structures 
{
	/**
	 * ...
	 * @author Hellrage
	 */
	
	import ManaMason.Structure;
	
	public class Pylon extends Structure
	{
		public function Pylon(bpIX:int, bpIY:int) 
		{
			var BUILDING_TYPE:Object = ManaMason.ManaMason.bezel.gameObjects.constants.buildingType;
			super("p", bpIX, bpIY);
			this.rendered = false;
			this.size = 2;
			this.xOffset = -4;
			this.yOffset = -5;
			
			this.buildingType = BUILDING_TYPE.PYLON;
			this.spellButtonIndex = 17;
		}
		
		public override function castBuild(spendMana:Boolean = true, trackStats:Boolean = false): void
		{
			var core:Object = ManaMason.ManaMason.bezel.gameObjects.GV.ingameCore;
			
			if (spendMana && core.getMana() < this.getCurrentManaCost())
				return;
				
			if (core.controller.isBuildingBuildPointFree(buildingGridX, buildingGridY, this.buildingType))
			{
				if (!core.calculator.isNew2x2BuildingBlocking(buildingGridX, buildingGridY))
				{
					core.creator.buildPylon(buildingGridX, buildingGridY);
					if (trackStats)
					{
						core.stats.spentManaOnPylons += Math.max(0, this.getCurrentManaCost());
					}
				}
				else return;
			}
			else return;
			
			if (spendMana)
			{
				core.changeMana( -this.getCurrentManaCost(), false, true);
				this.incrementManaCost();
			}
		}
	
		public override function incrementManaCost(): void
		{
			var GV:Object = ManaMason.ManaMason.bezel.gameObjects.GV;
			var core:Object = GV.ingameCore;
			core.currentPylonBuildingManaCost.s(Math.round(GV.PYLON_COST_MULT.g() * (core.currentPylonBuildingManaCost.g() + Math.round(GV.PYLON_COST_INCREMENT.g()))));
		}
		
		public override function getCurrentManaCost(): Number
		{
			var core:Object = ManaMason.ManaMason.bezel.gameObjects.GV.ingameCore;
			return core.currentPylonBuildingManaCost.g();
		}
		
		public override function insertGem(gem:Object): void
		{
			
		}
	}

}