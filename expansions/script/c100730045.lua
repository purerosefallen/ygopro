--高速决斗技能-唤龙者
Duel.LoadScript("speed_duel_common.lua")
function c100730045.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730045.skill,c100730045.con,aux.Stringid(100730045,0))
	aux.SpeedDuelBeforeDraw(c,c100730045.skill2)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730045.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,1,nil,43973174)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,17985575)
end
function c100730045.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,nil,43973174)
	local g2=g:Select(tp,1,1,nil)
	Duel.Hint(HINT_CARD,1-tp,100730045)
	if g2 then
		Duel.ConfirmCards(1-tp,g2)
		local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,17985575)
		local tc=g:GetFirst()
		Duel.SendtoHand(tc,nil,REASON_RULE)
	end
end
function c100730045.skill2(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1)
	e1:SetCondition(c100730045.condition)
	e1:SetOperation(c100730045.op)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730045.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and eg:GetFirst():IsSummonType(SUMMON_TYPE_NORMAL)
end
function c100730045.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,1-tp,100730045)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,43973174)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleHand(tp)
	end
end