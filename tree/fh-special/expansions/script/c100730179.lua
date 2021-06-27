--高速决斗技能-找回遗失物
Duel.LoadScript("speed_duel_common.lua")
function c100730179.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730179.operation,c100730179.con,aux.Stringid(100730179,0))
	local e1=Effect.GlobalEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c100730179.operation)
	c:RegisterEffect(e1)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730179.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_HAND,0,3,nil)
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_GRAVE,0,3,nil,0x12e)
end
function c100730179.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_HAND,0,nil)
	local c=g:Select(tp,3,3,nil)
	if c then
		Duel.SendtoGrave(c,REASON_EFFECT+REASON_DISCARD)
		Duel.Hint(HINT_CARD,1-tp,100730179)
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730179,0))
		local sg=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_GRAVE,0,3,nil,0x12e)
		local sc=sg:Select(tp,3,3,nil)
		Duel.SendtoDeck(sc,tp,0,REASON_RULE)
		Duel.Draw(tp,3,REASON_RULE)
	end
	e:Reset()  
end