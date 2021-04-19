--高速决斗技能-次元召唤
Duel.LoadScript("speed_duel_common.lua")
function c100730290.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730290.skill,c100730290.con,aux.Stringid(100730290,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730290.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(c100730290.filter,tp,LOCATION_HAND,0,1,nil)
end
function c100730290.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xe3) and c:IsLevelBelow(4)
end
function c100730290.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local c=e:GetHandler()
	local g1=Duel.SelectMatchingCard(tp,c100730290.filter,tp,LOCATION_HAND,0,1,1,nil)
	local tc=g1:GetFirst()
	Duel.Hint(HINT_CARD,1-tp,100730290)
	Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
	local e1=Effect.CreateEffect(tc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(c100730290.val)
	tc:RegisterEffect(e1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetLabel(1-tp)
	e1:SetOperation(c100730290.leaveop)
	e1:SetReset(RESET_EVENT+0xc020000)
	tc:RegisterEffect(e1,true)
end
function c100730290.val(e,c)
	return c:GetLevel()*500
end
function c100730290.leaveop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,100730290)
	Duel.PayLPCost(1-tp,c:GetLevel()*500)
	Duel.PayLPCost(tp,c:GetLevel()*500)   
end