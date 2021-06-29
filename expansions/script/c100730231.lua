--高速决斗技能-鲨鱼复仇
Duel.LoadScript("speed_duel_common.lua")
function c100730231.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730231.skill,c100730231.con,aux.Stringid(100730231,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730231.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetLP(tp)<Duel.GetLP(1-tp)
		and Duel.IsExistingMatchingCard(c100730231.rmfilter,tp,LOCATION_MZONE,0,1,nil) 
end
function c100730231.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730231)
	local g=Duel.GetMatchingGroup(c100730231.rmfilter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(c100730231.atkval)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c100730231.rmfilter(c)
	return c:GetOverlayCount()>=3 and c:IsAttribute(ATTRIBUTE_WATER) and c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsRankBelow(4)
end
function c100730231.atkval(e,c)
	return Duel.GetOverlayCount(e:GetHandlerPlayer(),1,0)*500
end