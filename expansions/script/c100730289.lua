--高速决斗技能-方界次元召唤
Duel.LoadScript("speed_duel_common.lua")
function c100730289.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730289.skill,c100730289.con,aux.Stringid(100730289,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730289.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMZoneCount(tp)>-1
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_HAND,0,1,nil,0xe3)
		and Duel.IsExistingMatchingCard(c100730289.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c100730289.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsSetCard(0xe3)
end
function c100730289.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.SelectMatchingCard(tp,c100730289.filter,tp, LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	local g1=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp, LOCATION_HAND,0,1,1,nil,0xe3)
	local c=g1:GetFirst()
	Duel.Hint(HINT_CARD,1-tp,100730289)
	Duel.SendtoGrave(tc,nil,REASON_RULE)
	Duel.SpecialSummon(c,0,tp,tp,true,true,POS_FACEUP)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(c100730289.val)
	c:RegisterEffect(e1)
	if c:GetLevel()<=4 then return end
	e:Reset()
end
function c100730289.val(e,c)
	return c:GetLevel()*500
end