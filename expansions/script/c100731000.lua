--高速决斗技能-最后一抽
Duel.LoadScript("speed_duel_common.lua")
function c100731000.initial_effect(c)
	aux.SpeedDuelReplaceDraw(c,c100731000.skill,c100731000.con,aux.Stringid(100731000,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100731000.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp and Duel.GetTurnCount(tp)>=4
end
function c100731000.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100731000,0)) then
		Duel.Hint(HINT_CARD,1-tp,100731000)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
		getmetatable(e:GetHandler()).announce_filter={TYPE_MONSTER+TYPE_TRAP+TYPE_SPELL,OPCODE_ISTYPE,TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK,OPCODE_ISTYPE,OPCODE_NOT,OPCODE_AND}
		local ac=Duel.AnnounceCard(tp,table.unpack(getmetatable(e:GetHandler()).announce_filter))
		local c=Duel.CreateToken(tp,ac)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
		local e1=Effect.GlobalEffect()
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetLabel(1)
		e1:SetCountLimit(1)
		e1:SetOperation(c100731000.skilllose)
		Duel.RegisterEffect(e1,tp,true)
		e:Reset()
	end
end

function c100731000.skilllose(e,tp)
	Duel.Hint(HINT_CARD,1-tp,100731000)
	local lp=Duel.GetLP(tp)
	Duel.Damage(tp,lp,REASON_RULE)
end
