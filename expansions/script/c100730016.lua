--高速决斗技能-磁吸引力
Duel.LoadScript("speed_duel_common.lua")
function c100730016.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730016.skill,c100730016.con,aux.Stringid(100730016,0))
	aux.SpeedDuelBeforeDraw(c,c100730016.skill2)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730016.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_HAND,0,2,nil,0x2066)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,75347539)
end
function c100730016.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_HAND,0,nil,0x2066)
	local g2=g:Select(tp,2,2,nil)
	Duel.Hint(HINT_CARD,1-tp,100730016)
	if g2 then
		Duel.ConfirmCards(1-tp,g2)
		local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,75347539)
		local tc=g:GetFirst()
		Duel.SendtoHand(tc,nil,REASON_RULE)
	end
end
function c100730016.skill2(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1)
	e1:SetCondition(c100730016.condition)
	e1:SetOperation(c100730016.op)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730016.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and eg:GetFirst():IsSummonType(SUMMON_TYPE_NORMAL)
end
function c100730016.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,1-tp,100730016)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c100730016.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c100730016.filter(c)
	return c:IsSetCard(0x2066) and c:IsAbleToHand() and c:IsLevelBelow(4)
end