--高速决斗技能-魔术手
Duel.LoadScript("speed_duel_common.lua")
function c100730302.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(67048711,c)
	if not c100730302.UsedLP then
		c100730302.UsedLP={}
		c100730302.UsedLP[0]=0
		c100730302.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730302.skill,c100730302.con,aux.Stringid(100730302,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730302.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and aux.DecreasedLP[tp]-c100730302.UsedLP[tp]>=1500
end
function c100730302.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	c100730302.UsedLP[tp]=c100730302.UsedLP[tp]+1500
	Duel.Hint(HINT_CARD,1-tp,100730302)
	local c=Duel.CreateToken(tp,86198326)
	Duel.SendtoHand(c,nil,REASON_RULE)
end