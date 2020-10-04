--高速决斗技能-魔术手
Duel.LoadScript("speed_duel_common.lua")
function c100730071.initial_effect(c)
	if not c100730071.UsedLP then
		c100730071.UsedLP={}
		c100730071.UsedLP[0]=0
		c100730071.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730071.skill,c100730071.con,aux.Stringid(100730071,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730071.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
		and aux.DecreasedLP[tp]-c100730071.UsedLP[tp]>=1500
		and c100730071.UsedLP[tp]<3000
end
function c100730071.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	c100730071.UsedLP[tp]=c100730071.UsedLP[tp]+1500
	Duel.Hint(HINT_CARD,1-tp,100730071)
	local c=Duel.CreateToken(tp,86198326)
	Duel.SendtoHand(c,nil,REASON_RULE)
end