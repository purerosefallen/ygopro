--高速决斗技能-门神呼唤
Duel.LoadScript("speed_duel_common.lua")
function c100730137.initial_effect(c)
	if not c100730137.UsedLP then
		c100730137.UsedLP={}
		c100730137.UsedLP[0]=0
		c100730137.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730137.skill,c100730137.con,aux.Stringid(100730137,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730137.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
		and aux.DecreasedLP[tp]-c100730137.UsedLP[tp]>=1800
		and c100730137.UsedLP[tp]<3600
end
function c100730137.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	c100730137.UsedLP[tp]=c100730137.UsedLP[tp]+1800
	Duel.Hint(HINT_CARD,1-tp,100730137)
	local c=Duel.CreateToken(tp,25833572)
	Duel.SendtoHand(c,nil,REASON_RULE)
end