--高速决斗技能-恶魔送行
Duel.LoadScript("speed_duel_common.lua")
function c100730261.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730261.skill,c100730261.con,aux.Stringid(100730261,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730261.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.IsExistingMatchingCard(c100730261.filter,tp,LOCATION_DECK,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsType,tp,0,LOCATION_GRAVE,1,nil,TYPE_MONSTER)
end
function c100730261.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	if not Duel.SelectYesNo(tp,aux.Stringid(100730261,0)) then return end
	Duel.Hint(HINT_CARD,1-tp,100730261)
	local g1=Duel.GetMatchingGroup(Card.IsType,tp,0,LOCATION_GRAVE,nil,TYPE_MONSTER)
	local g2=Duel.GetMatchingGroup(c100730261.filter,tp,LOCATION_DECK,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=g1:Select(tp,1,1,nil)
	Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=g2:Select(tp,1,1,nil)
	Duel.SendtoGrave(tc,REASON_EFFECT)
end
function c100730261.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave() and c:IsRace(RACE_FIEND)
end