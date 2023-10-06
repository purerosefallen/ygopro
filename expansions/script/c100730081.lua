--高速决斗技能-我的名字叫于贝尔
Duel.LoadScript("speed_duel_common.lua")
function c100730081.initial_effect(c)
	if not c100730081.UsedLP then
		c100730081.UsedLP={}
		c100730081.UsedLP[0]=0
		c100730081.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730081.skill,c100730081.con,aux.Stringid(100730081,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730081.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
		and aux.DecreasedLP[tp]-c100730081.UsedLP[tp]>=1000
		and c100730081.UsedLP[tp]<3000
end
function c100730081.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	c100730081.UsedLP[tp]=c100730081.UsedLP[tp]+1000
	Duel.Hint(HINT_CARD,1-tp,100730081)
	local c=Duel.CreateToken(tp,78371393)
	Duel.SendtoHand(c,nil,REASON_RULE)
	Duel.ConfirmCards(1-tp,c)
end