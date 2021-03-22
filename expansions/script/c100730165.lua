--高速决斗技能-契约的门扉
Duel.LoadScript("speed_duel_common.lua")
function c100730165.initial_effect(c)
	if not c100730165.UsedLP then
		c100730165.UsedLP={}
		c100730165.UsedLP[0]=0
		c100730165.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730165.skill,c100730165.con,aux.Stringid(100730165,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730165.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
		and aux.DecreasedLP[tp]-c100730165.UsedLP[tp]>=2000
		and c100730165.UsedLP[tp]<4000
end
function c100730165.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	c100730165.UsedLP[tp]=c100730165.UsedLP[tp]+2000
	Duel.Hint(HINT_CARD,1-tp,100730165)
	local c=Duel.CreateToken(tp,18809562)
	Duel.SendtoHand(c,nil,REASON_RULE)
	Duel.ConfirmCards(1-tp,c)
	local d=Duel.CreateToken(tp,83764718)
	Duel.SendtoHand(d,1-tp,REASON_RULE)
	Duel.ConfirmCards(tp,d)
end