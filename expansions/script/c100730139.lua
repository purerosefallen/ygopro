--高速决斗技能-希望的战士：No.39
Duel.LoadScript("speed_duel_common.lua")
function c100730139.initial_effect(c)
	aux.SpeedDuelMoveCardToDeckCommon(84013237,c)
	aux.SpeedDuelMoveCardToDeckCommon(62517849,c)
	aux.SpeedDuelMoveCardToDeckCommon(56840427,c)
	aux.SpeedDuelMoveCardToDeckCommon(66970002,c)
	aux.SpeedDuelMoveCardToDeckCommon(56832966,c)
	aux.SpeedDuelMoveCardToDeckCommon(21521304,c)
	aux.SpeedDuelMoveCardToDeckCommon(86532744,c)
	aux.SpeedDuelMoveCardToDeckCommon(87911394,c)
	aux.SpeedDuelMoveCardToDeckCommon(84124261,c)
	aux.SpeedDuelMoveCardToDeckCommon(83880087,c)
	if not c100730139.UsedLP then
		c100730139.UsedLP={}
		c100730139.UsedLP[0]=0
		c100730139.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730139.skill,c100730139.con,aux.Stringid(100730139,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730139.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,84013237)
		and aux.DecreasedLP[tp]-c100730139.UsedLP[tp]>=2000
end
function c100730139.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	c100730139.UsedLP[tp]=c100730139.UsedLP[tp]+2000
	Duel.Hint(HINT_CARD,1-tp,100730139)
	local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_GRAVE,0,1,1,nil,84013237)
	if not g then return end
	Duel.SendtoDeck(g,nil,2,REASON_RULE)
	local c=Duel.CreateToken(tp,94807487)
	Duel.SendtoHand(c,nil,REASON_RULE)
end