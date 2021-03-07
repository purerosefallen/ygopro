--高速决斗技能-天使回归
Duel.LoadScript("speed_duel_common.lua")
function c100730131.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730131.skill,c100730131.con,aux.Stringid(100730131,0))
	aux.SpeedDuelMoveCardToDeckCommon(51960178,c)
	aux.SpeedDuelMoveCardToDeckCommon(23454876,c)
	aux.SpeedDuelMoveCardToDeckCommon(45939611,c)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730131.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
	and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,51960178)
end
function c100730131.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730131)
	local h1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_GRAVE,0,1,1,nil,51960178)
	if h1>2 or not g then return end
	Duel.SendtoDeck(g,nil,2,REASON_RULE)
	local c=Duel.CreateToken(tp,47660516)
	Duel.SendtoHand(c,nil,REASON_RULE)
end