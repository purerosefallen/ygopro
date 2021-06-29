--高速决斗技能-真红之王
Duel.LoadScript("speed_duel_common.lua")
function c100730251.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730251.skill,c100730251.con,aux.Stringid(100730251,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730251.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsSetCard(0x1045)
end
function c100730251.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730251.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c100730251.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730251)
	local g=Duel.GetMatchingGroup(c100730251.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
		e1:SetValue(tc:GetLevel()*100)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end