--高速决斗技能-跃迁
Duel.LoadScript("speed_duel_common.lua")
function c100730123.initial_effect(c)
	aux.SpeedDuelMoveCardToDeckCommon(4545854,c)
	aux.SpeedDuelAtMainPhase(c,c100730123.skill,c100730123.con,aux.Stringid(100730123,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730123.Is2000(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT)
end

function c100730123.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730123.Is2000,tp,LOCATION_MZONE,0,3,nil)
end
function c100730123.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730123)
	local g=Duel.GetMatchingGroup(c100730123.Is2000,tp,LOCATION_MZONE,0,1,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(8)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end